const express = require("express");
const mongoose = require("mongoose");
const Wallpaper = require("../model/wallpaper");
const wallpaperRoute = express.Router();

wallpaperRoute.post("/post-wallpaper", async (req, res) => {
    try {
        const {wallpaperName, wallpaperCategory, wallpaperUrl, name} = req.body;
        let wallpaper = new Wallpaper({
            wallpaperName,
            wallpaperCategory,
            wallpaperUrl,
            name,
        })
        wallpaper = await wallpaper.save();
        res.json(wallpaper);
    } catch (err) {
        res.status(500).json({error: err.message});
    }
});