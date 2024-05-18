import { Router } from "express"
import Utilisateur from "../models/utilisateur.js"
import { authenticateToken, generateAccessToken } from "../middleware.js"
import bcrypt from "bcrypt"
const router = Router()

router.post("/login", async (req, res) => {
  try {
    const { login, password } = req.body
    if (login == null || password == null) {
      res
        .status(400)
        .send({ message: "Please provide login and password", status: "error" })
      return
    }
    const user = await Utilisateur.findOne({
      $or: [{ telephone: login }, { email: login }],
    }).select("-carteBancaire")
    if (user.$isEmpty()) {
      res.status(400).send({ message: "User not found", status: "error" })
      return
    }
    if (!bcrypt.compareSync(password, user.password)) {
      res.status(400).send({ message: "password incorrect", status: "error" })
      return
    }

    const token = generateAccessToken(user.id)
    res.send({
      message: "User logged in successfully",
      status: "success",
      data: {
        token,
        user,
      },
    })
  } catch (error) {
    res.status(500).json({ message: error.message, status: "error" })
  }
})

router.post("/registre", async (req, res) => {
  try {
    const { nom, prenom, telephone, email, password } = req.body
    if (
      nom == null ||
      prenom == null ||
      telephone == null ||
      email == null ||
      password == null
    ) {
      res.status(400).send("Please provide user information")
      return
    }
    cryptedPassword = await bcrypt.hash(password, 10)
    const user = new Utilisateur({
      nom,
      prenom,
      telephone,
      email,
      cryptedPassword,
    })
    await user.save()
    res.send({ message: "User created successfully", status: "success" })
  } catch (error) {
    res.status(500).json({ message: error.message, status: "error" })
  }
})

export default router
