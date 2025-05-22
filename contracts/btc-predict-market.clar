;; Title: BitForecast - Bitcoin Price Prediction Markets
;;
;; Summary: A decentralized prediction market platform allowing users to stake STX
;; on the future price movements of Bitcoin and other assets.
;;
;; Description: BitForecast enables users to participate in prediction markets by staking
;; STX on whether an asset's price will go up or down within a specified timeframe.
;; Once markets are resolved by the trusted oracle, winners can claim their proportional
;; share of the total pool, minus a small platform fee.
;;
;; The contract implements several key mechanisms:
;; - Market creation with defined start/end blocks and initial price
;; - User prediction staking with minimum requirements
;; - Oracle-based market resolution
;; - Proportional reward distribution
;; - Administrative controls for platform parameters
;;
;; Security features include:
;; - Restricted administrative functions
;; - Balance verification before transfers
;; - Claim verification to prevent double-claiming
;; - Parameter validation to prevent invalid inputs

;; Constants

;; Administrative
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))

;; Error codes
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; State Variables

;; Platform configuration
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(define-data-var minimum-stake uint u1000000) ;; 1 STX minimum stake
(define-data-var fee-percentage uint u2) ;; 2% platform fee
(define-data-var market-counter uint u0)

;; Data Maps

;; Market data structure
(define-map markets
  uint
  {
    start-price: uint,
    end-price: uint,
    total-up-stake: uint,
    total-down-stake: uint,
    start-block: uint,
    end-block: uint,
    resolved: bool,
  }
)