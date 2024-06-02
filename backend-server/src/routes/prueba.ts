import express from 'express';

const router = express.Router();


router.use(express.json);
router.use(express.text);

router.get("/prueba");

export {router};