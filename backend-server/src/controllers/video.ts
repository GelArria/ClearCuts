import { NextFunction, Request, Response } from "express";
import { Video } from "../model/Video.js";
import { VideoNotExistsError } from "../model/errors/VideoNotExistsError.js";

const BASE_URI = process.env.VIDEOS_FOLDER;

export async function getVideo(req:Request, res:Response, next:NextFunction){
    const array = req.params.name.split('.');
    const format = array.pop() as string;
    const name = array.join('.');

    console.log(`name: ${name}, format: ${format}`)

    const video = new Video(name, format);

    try {
        await video.setFrameRate();
        await video.getFrames();
        await video.getAudio();
        
        /*

        .
        .
        .
        Procesamiento del modelo a cada frame
        .
        .
        .

        */

        await Video.createVideo(video);
        res.status(200).sendFile('output.mp4', {root: `${BASE_URI}/${name}`});
        
    } catch (error:any) {
        next(error);
    }

}