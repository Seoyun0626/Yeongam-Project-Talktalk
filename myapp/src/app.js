// import express from 'express';
// import cors from 'cors';
// import path from 'path';
// import { createServer } from 'http';
// // import ServerSocket from 'socket.io';
// import routesUser from './routes/user_routes';
// import routesAuth from './routes/auth_routes';
// // import routesPost from './routes/post.routes';
// // import routesNotifications from './routes/notifications.routes';
// // import routesStory from './routes/story.routes';
// // import routesChat from './routes/chat.routes';
// // import { socketChatMessages } from './sockets/chat_socket';


const express = require('express');
const cors = require('cors');
const path = require('path');
const createServer = require('http');
const {promisfy} = require('promisfy');
const bodyParser = require('body-parser');


const routeUser = require('./routes/user_routes');
const routeAuth = require('./routes/auth_routes');

const app = express();
const port = process.env.PORT;


class App {

    constructor() {
        this.apiRoutes = {
            user: '/api',
            auth: '/api',
            // post: '/api',
            // notification: '/api',
            // story: '/api',
            // chat: '/api',
        };
        this.app = express();
        this.httpServer = createServer(this.app);
        this.middlewares();
        this.routes();
        // this.configServerSocket();
    }
    middlewares() {
        this.app.use(cors());
        this.app.use(express.json());
        this.app.use(express.urlencoded({ extended: false }));
        // this.app.use(express.static(path.resolve('uploads/profile')));
        // this.app.use(express.static(path.resolve('uploads/profile/cover')));
        // this.app.use(express.static(path.resolve('uploads/posts')));
        // this.app.use(express.static(path.resolve('uploads/stories')));
    }
    routes() {
        this.app.use(this.apiRoutes.user, routesUser);
        this.app.use(this.apiRoutes.auth, routesAuth);
        // this.app.use(this.apiRoutes.post, routesPost);
        // this.app.use(this.apiRoutes.notification, routesNotifications);
        // this.app.use(this.apiRoutes.story, routesStory);
        // this.app.use(this.apiRoutes.chat, routesChat);
    }
    // configServerSocket() {
    //     const io = new ServerSocket(this.httpServer);
    //     socketChatMessages(io);
    // }
    async listen(port) {
        await this.httpServer.listen(port);
        console.log(`SERVER RUN ON PORT ${port}`);
    }
}
