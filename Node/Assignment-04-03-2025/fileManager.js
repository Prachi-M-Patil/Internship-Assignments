
const fs = require('fs');

const createFile = (fileName, content, callback) => {
    const buffer = Buffer.from(content);
    fs.writeFile(fileName, buffer, callback);
};

const appendToFile = (fileName, content, callback) => {
    const buffer = Buffer.from(content);
    fs.appendFile(fileName, buffer, callback);
};

const readFile = (fileName, callback) => {
    setTimeout(() => {
        fs.readFile(fileName, (err, data) => {
            if (err) {
                return callback(err);
            }
            callback(null, data.toString());
        });
    }, 3000); 
};

const deleteFile = (fileName, callback) => {
    fs.unlink(fileName, callback);
};

module.exports = {
    createFile,
    appendToFile,
    readFile,
    deleteFile
};
