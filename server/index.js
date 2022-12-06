const express = require("express");
const mongoose = require("mongoose");

const PORT = process.env.PORT || 3000;
const app = express();

//pages
const userRouter = require("./routers/auth");
const wallpaperRoute = require("./routers/wallpaper");

//Database
const DB = "mongodb+srv://wallpaper_app:wallpaper1234@cluster0.b8p6yng.mongodb.net/?retryWrites=true&w=majority"

app.use(express.json());
app.use(userRouter);
app.use(wallpaperRoute);

mongoose.connect(DB).then(() => {
    console.log("Conncted to DB successfully");
}).catch((e) => {console.log(`Error is ${e}`);})

app.listen(PORT, "0.0.0.0",() => {
    console.log("Connection successful");
})