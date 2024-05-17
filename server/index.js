import express, { json } from 'express';
import { dbConnect } from './db.js';
import Utilisateur from './models/utilisateur.js';
const app = express()
const port = 3000

app.use(json())

dbConnect()

app.get('/', async (req, res) => {
    const user = new Utilisateur({
        nom: "sabkari",
        email: "abderrahmanesabkari@gmail.com",
        prenom: "abderrahmane",
        telephone: 777524479
    });

    await user.save();
    res.send(await Utilisateur.find())
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})
