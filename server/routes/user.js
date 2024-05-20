import { Router } from "express"
import Utilisateur from "../models/utilisateur.js"
import { authenticateToken, generateAccessToken } from "../middleware.js"
import { body } from "express-validator"
const router = Router()

// data validator for updateUser
const userValidator = [
  body("id").trim().notEmpty(),
  body("nom").trim().notEmpty(),
  body("prenom").trim().notEmpty(),
  body("telephone").trim().notEmpty().isLength({ min: 8 }),
  (req, res, next) => {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res
        .status(400)
        .json({ message: "Validation failed", errors: errors.array() })
    }
    next()
  },
]

// update user
router.put("/update", authenticateToken, userValidator, async (req, res) => {
  const { id, nom, prenom, telephone } = req.body

  try {
    // Find the user by ID and update the fields
    const updatedUser = await Utilisateur.findByIdAndUpdate(
      id,
      {
        nom,
        prenom,
        telephone,
      },
      { new: true, runValidators: true } // Return the updated document and run validators
    )

    if (!updatedUser) {
      return res
        .status(404)
        .json({ message: "Utilisateur non trouvé", status: "error" })
    }

    res.json({ status: "success", message: "User updated successfully" })
  } catch (error) {
    console.error(error.message)
    res.status(500).json({ message: error.message, status: "error" })
  }
})

// data validator for carte bancaire
const carteValidator = [
  body("nomProprietaire").trim().notEmpty(),
  body("numCarte").trim().notEmpty().isNumeric(),
  body("cvv").trim().notEmpty().isNumeric(),
  body("dateExperation").trim().notEmpty().isISO8601().toDate(),
  (req, res, next) => {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res
        .status(400)
        .json({ message: "Validation failed", errors: errors.array() })
    }
    next()
  },
]

// add carte bancaire

router.post("/addCarte", authenticateToken, (req, res) => {
  try {
  } catch (error) {
    console.error(error.message)
    res.status(500).json({ message: error.message, status: "error" })
  }
})

export default router
