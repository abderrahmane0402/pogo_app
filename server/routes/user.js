import { Router } from "express"
import Utilisateur from "../models/utilisateur.js"
import { authenticateToken, generateAccessToken } from "../middleware.js"
import { body, param, validationResult } from "express-validator"
const router = Router()

// data validator for getUser
const getUserValidator = [
  param("id").trim().notEmpty(),
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

// getUser
router.get("/:id", authenticateToken, async (req, res) => {
  const id = req.params.id
  try {
    const user = await Utilisateur.findById(id).select([
      "-password",
      "-carteBancaire",
    ])
    if (!user) {
      return res
        .status(404)
        .json({ message: "Utilisateur non trouvé", status: "error" })
    }
    res.json({ status: "success", user })
  } catch (error) {
    console.error(error.message)
    res.status(500).json({ message: error.message, status: "error" })
  }
})

// data validator for updateUser
const userValidator = [
  param("id").trim().notEmpty(),
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
router.put(
  "/update/:id",
  authenticateToken,
  userValidator,
  async (req, res) => {
    const id = req.params.id
    const { nom, prenom, telephone } = req.body
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
  }
)

// data validator for carte bancaire
const carteValidator = [
  param("id").trim().notEmpty(),
  body("nomProprietaire").trim().notEmpty(),
  body("isdefault").trim().notEmpty().isBoolean(),
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

router.post(
  "/addCarte/:id",
  authenticateToken,
  carteValidator,
  async (req, res) => {
    try {
      const { nomProprietaire, numCarte, cvv, dateExperation, isdefault } =
        req.body
      const { id } = req.params

      // Find the user by ID
      const utilisateur = await Utilisateur.findById(id)
      if (!utilisateur) {
        return res
          .status(404)
          .json({ message: "Utilisateur non trouvé", status: "error" })
      }

      // Create a new card object
      const newCard = {
        nomProprietaire,
        numCarte,
        cvv,
        dateExperation,
        isdefault,
      }

      const carteNumber = utilisateur.carteBancaire.length
      if (carteNumber == 0) {
        newCard.isdefault = true
      } else if (isdefault == "true") {
        const defaultCard = utilisateur.carteBancaire.find(
          (carte) => carte.isdefault
        )
        if (defaultCard) {
          defaultCard.isdefault = false
        }
      }

      // Add the new card to the user's carteBancaire array
      utilisateur.carteBancaire.push(newCard)

      // Save the updated user
      await utilisateur.save()

      res
        .status(201)
        .json({ message: "Carte ajoutée avec succès", status: "success" })
    } catch (error) {
      console.error(error.message)
      res.status(500).json({ message: error.message, status: "error" })
    }
  }
)

// get default carte bancaire
router.get(
  "/defaultCarte/:id",
  param("id").trim().notEmpty(),
  async (req, res) => {
    try {
      const { id } = req.params

      const errors = validationResult(req)
      if (!errors.isEmpty()) {
        return res
          .status(400)
          .json({ message: "Validation failed", errors: errors.array() })
      }

      // Find the user by ID
      const utilisateur = await Utilisateur.findById(id).select("carteBancaire")
      if (!utilisateur) {
        return res
          .status(404)
          .json({ message: "Utilisateur non trouvé", status: "error" })
      }
      const carteNumber = utilisateur.carteBancaire.length
      if (carteNumber == 0) {
        return res
          .status(404)
          .json({ message: "ajouter une carte bancaire", status: "error" })
      }

      const defaultCard = utilisateur.carteBancaire.find(
        (carte) => carte.isdefault
      )
      if (!defaultCard) {
        return res.status(404).json({ message: "Carte bancaire non trouvée" })
      }

      res.status(201).json({ carte: defaultCard, status: "success" })
    } catch (error) {
      console.error(error.message)
      res.status(500).json({ message: error.message, status: "error" })
    }
  }
)

// delete carte bancaire
router.delete(
  "/deleteCarte/:id",
  param("id").trim().notEmpty(),
  async (req, res) => {
    try {
      const { id } = req.params

      const errors = validationResult(req)
      if (!errors.isEmpty()) {
        return res
          .status(400)
          .json({ message: "Validation failed", errors: errors.array() })
      }

      // Find the user by ID
      

      res.status(201).json({ carte: defaultCard, status: "success" })
    } catch (error) {
      console.error(error.message)
      res.status(500).json({ message: error.message, status: "error" })
    }
  }
)

export default router
