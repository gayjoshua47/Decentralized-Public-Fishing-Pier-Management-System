(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u400))
(define-constant ERR-INVALID-INPUT (err u401))
(define-constant ERR-STATION-NOT-FOUND (err u402))

(define-data-var next-station-id uint u1)
(define-data-var next-reservation-id uint u1)
(define-data-var cleaning-fee uint u10)

(define-map cleaning-stations
  { station-id: uint }
  {
    location: (string-ascii 50),
    hourly-rate: uint,
    is-operational: bool,
    total-usage-hours: uint
  }
)

(define-map reservations
  { reservation-id: uint }
  {
    user: principal,
    station-id: uint,
    duration-hours: uint,
    total-cost: uint,
    status: (string-ascii 20)
  }
)

(define-public (add-cleaning-station (location (string-ascii 50)) (hourly-rate uint))
  (let (
    (station-id (var-get next-station-id))
  )
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (asserts! (> (len location) u0) ERR-INVALID-INPUT)
    (asserts! (> hourly-rate u0) ERR-INVALID-INPUT)

    (map-set cleaning-stations
      { station-id: station-id }
      {
        location: location,
        hourly-rate: hourly-rate,
        is-operational: true,
        total-usage-hours: u0
      }
    )

    (var-set next-station-id (+ station-id u1))
    (ok station-id)
  )
)

(define-public (reserve-station (station-id uint) (duration-hours uint))
  (let (
    (reservation-id (var-get next-reservation-id))
  )
    (asserts! (> duration-hours u0) ERR-INVALID-INPUT)
    (match (map-get? cleaning-stations { station-id: station-id })
      station-data (let (
        (total-cost (* (get hourly-rate station-data) duration-hours))
      )
        (map-set reservations
          { reservation-id: reservation-id }
          {
            user: tx-sender,
            station-id: station-id,
            duration-hours: duration-hours,
            total-cost: total-cost,
            status: "active"
          }
        )

        (var-set next-reservation-id (+ reservation-id u1))
        (ok reservation-id)
      )
      ERR-STATION-NOT-FOUND
    )
  )
)

(define-public (complete-cleaning (reservation-id uint))
  (match (map-get? reservations { reservation-id: reservation-id })
    reservation-data (begin
      (asserts! (is-eq (get user reservation-data) tx-sender) ERR-NOT-AUTHORIZED)
      (map-set reservations
        { reservation-id: reservation-id }
        (merge reservation-data { status: "completed" })
      )
      (ok true)
    )
    (err u404)
  )
)

(define-read-only (get-station (station-id uint))
  (map-get? cleaning-stations { station-id: station-id })
)

(define-read-only (get-reservation (reservation-id uint))
  (map-get? reservations { reservation-id: reservation-id })
)
