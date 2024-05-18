import { Router } from "express"
import Utilisateur from "../models/utilisateur.js"
import { authenticateToken, generateAccessToken } from "../middleware.js"
const router = Router()

router.put("/update", authenticateToken, (req, res) => {
    
})

export default router
