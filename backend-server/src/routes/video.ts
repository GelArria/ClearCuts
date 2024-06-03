import express from 'express';
import { getVideo } from '../controllers/video.js';

const router = express.Router();


router.use(express.json());
router.use(express.text());

router.get("/video/:name", getVideo);

export {router};