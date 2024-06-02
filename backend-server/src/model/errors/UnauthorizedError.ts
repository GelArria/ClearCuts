class UnauthorizedError extends Error {

    statusCode:number;
  
      constructor(message:string, statusCode:number) {
        super(message);
        this.name = 'UnauthorizedError';
        this.statusCode = statusCode;
      }
  }
  
  export {UnauthorizedError};