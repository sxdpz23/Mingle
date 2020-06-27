const app = require("express")();
const http = require("http").createServer(app);
const io = require("socket.io")(http);

app.get("/", (req, res) => {
    res.send("Node Server is running. Yay!!");
});

//Socket Logic (For Broadcasting)
// const socketio = require("socket.io")(http);

// socketio.on("connection", (userSocket) => {
//     userSocket.on("send_message", (data) => {
//         userSocket.broadcast.emit("receive_message", data);
//     });
// });

//Logic (For Private Chats)
io.on("connection", (socket) => {
    //Get the chatID of the user and join in a room of the same chatID
    citID = socket.handshake.query.citID;
    socket.join(citID);

    //Leave the room if the user closes the socket
    socket.on("disconnect", () => {
        socket.leave(citID);
    });

    //Send message to only a particular user
    socket.on("send_message", (message) => {
        receiverCitotoID = message.receiverCitotoID;
        senderCitotoID = message.senderCitotoID;
        content = message.content;

        //Send message to only that particular room
        socket.in(receiverChatID).emit("receive_message", {
            content: content,
            senderCitotoID: senderCitotoID,
            receiverCitotoID: receiverCitotoID,
        });
    });
});

http.listen(process.env.PORT);