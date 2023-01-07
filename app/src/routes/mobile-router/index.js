const App = require('../../app');
const config = require('dotenv');

const main = async() => {

    config();

    const app = new App();
    await app.listen(process.env.PORT || '3000');
}

main();