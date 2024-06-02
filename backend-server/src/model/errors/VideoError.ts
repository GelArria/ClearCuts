class VideoError extends Error {
  
      constructor(message:string) {
        super(message);
        this.name = 'VideoError';
      }
  }
  
  export {VideoError};