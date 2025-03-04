const fileManager = require('./fileManager');

console.log("current file path:", __filename);
console.log("current directory path:", __dirname);
console.log("process Id", process.pid);
console.log("Node.js version", process.version);
console.log("OS platform:", process.platform);
console.log("current working directory: ", process.cwd());
// console.log("Environment variables:", process.env);

setInterval(() => {
    console.log("System status: set interval after each 5 seconds");
}, 5000);

fileManager.createFile('example.txt', 'Hello world', (err) => {
    if (err) {
        throw err;
    }
    console.log("File written successfully.");

    fileManager.appendToFile('example.txt', '\n new line!', (err) => {
        if (err) {
            throw err;
        }
        console.log('File text appended.');

        fileManager.readFile('example.txt', (err, data) => {
            if (err) {
                console.error("Error reading file:", err);
                return;
            }
            console.log("File content:", data);

            // Create a new file
            fileManager.createFile('newfile.txt', 'This is a new file.', (err) => {
                if (err) {
                    throw err;
                }
                console.log('New file created.');

                // Delete file
                fileManager.deleteFile('example.txt', (err) => {
                    if (err) throw err;
                    console.log('File deleted');
                });
            });
        });
    });
});
