import { exp } from "@tensorflow/tfjs";

class VideoNotExistsError extends Error {
    constructor(message: string) {
        super(message);
        this.name = 'VideoNotExistsError';
    }
}

export { VideoNotExistsError };