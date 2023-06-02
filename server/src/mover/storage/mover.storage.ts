import { diskStorage } from 'multer';
import path = require('path');
import { join } from 'path';
import { v4 as uuidv4 } from 'uuid';

// how images are stored. uuid added to the end of the filename to keep names unique.
// saved in uploads folder
// to make the entire name uuid instead of name + uuid, remove the path.parse part of filename on line 13/14  
export const storage = {                                                                                
  storage: diskStorage({                                                                                
    destination: './uploads/',                                                                          
    filename: (req, file, cb) => {
      const filename: string =
        path.parse(file.originalname).name.replace(/\s/g, '') + uuidv4();       // can keep just uuidv4 instead
      console.log(filename);
      const extension: string = path.parse(file.originalname).ext;
      cb(null, `${filename}${extension}`);
    },
  }),
};
