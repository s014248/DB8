import SwiftUI

struct ChatMessage : Hashable {
    var message: String
    var avatar: String
    var color: Color
    var isMe: Bool = false
}

struct ChatRow : View {
    var chatMessage: ChatMessage
    var body: some View {//adfsklasdfkjkdjshfkjqsdfwelfqwqefkj
        Group {
            if !chatMessage.isMe {
                HStack {
                    Group {
                        Text(chatMessage.avatar)
                        Text(chatMessage.message)
                            .bold()
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(chatMessage.color)
                            .cornerRadius(10)
                    }
                }
            } else {
                HStack {
                    Group {
                        Spacer()
                        Text(chatMessage.message)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(chatMessage.color)
                        .cornerRadius(10)
                        Text(chatMessage.avatar)
                    }
                }
            }
        }

    }
}

struct ChatContentView : View {
    
    @State var composedMessage: String = ""
    @EnvironmentObject var chatController: ChatViewController
    
    var body: some View {
      
        VStack {
            List {
                
                ForEach(chatController.messages, id: \.self) { msg in
                    ChatRow(chatMessage: msg)
                }
            }
            
            HStack {
                TextField("Message...", text: $composedMessage).frame(minHeight: CGFloat(30))
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
        }
    }
    func sendMessage() {
        if (composedMessage != ""){
            chatController.sendMessage(ChatMessage(message: composedMessage, avatar: "Me", color: .green, isMe: true))
            composedMessage = ""
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ChatContentView()
        .environmentObject(ChatViewController())
    }
}
#endif
