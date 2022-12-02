const mongoose = require("mongoose");

const wallpaperSchema = mongoose.Schema({
    wallpaperName : {
        type: String,
        required: true,

    },
    wallpaperUrl: {
        type: String,
        required: true,
    },
    wallpaperCategory: {
        type: String,
        required: true,
    },
    name: {
        type: String,
        required: true,
    }
});

const Wallpaper = mongoose.model("Wallpaper", wallpaperSchema);
module.exports = Wallpaper;