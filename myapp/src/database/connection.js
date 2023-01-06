
const createPool = require('mysql');

const connect = async () => {
    const connection = await createPool({
        host: 'localhost',
        user: 'root',
        password: '1004',
        database: 'webdb',
        connectionLimit: 10
    });
    return connection;
};

module.exports = connect