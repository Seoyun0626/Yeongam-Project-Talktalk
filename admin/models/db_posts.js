var db_config = require(__dirname + '/db.js');
var conn = db_config.init();
db_config.connect(conn);
const postsModel = {
    getPosts: function (callback) {
        conn.query('SELECT * FROM posts', function (err, rows) {
            if (err) {
                console.log(err);
            }
            callback(rows);
        });
    },
    getPost: function (id, callback) {
        conn.query('SELECT * FROM posts WHERE id = ?', [id], function (err, rows) {
            if (err) {
                console.log(err);
            }
            callback(rows);
        });
    },
    writePost: function (title, content, callback) {
        conn.query('INSERT INTO posts (title, content) VALUES (?, ?)', [title, content], function (err, rows) {
            if (err) {
                console.log(err);
            }
            callback(rows);
        });
    },
    updatePost: function (id, title, content, callback) {
        conn.query('UPDATE posts SET title = ?, content = ? WHERE id = ?', [title, content, id], function (err, rows) {
            if (err) {
                console.log(err);
            }
            callback(rows);
        });
    },
    deletePost: function (id, callback) {
        conn.query('DELETE FROM posts WHERE id = ?', [id], function (err, rows) {
            if (err) {
                console.log(err);
            }
            callback(rows);
        });
    }
};
module.exports = postsModel;
// Path: models\db_users.js
// Compare this snippet from routes\controller.js:
