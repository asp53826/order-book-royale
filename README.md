# Order Book Royale

A four-minute market battle played on one deterministic limit order book.

**Play:** <https://asp53826.github.io/order-book-royale/>

Up to eight traders begin with $1 million. Post bids and offers, trade against the shared book, react to private news, and stay above a rising margin line. Empty seats are filled by market-making and informed-flow bots. The richest surviving trader at the bell wins.

## Why the result is auditable

- The JavaScript matching engine preserves integer ticks and price-time priority.
- A Python-generated workload replays 4,000 operations through both implementations.
- CI compares every trade, top of book, resting count, and depth level.
- A round is fully described by its seed, roster, and intent log.
- The host commits to a SHA-256 seed hash before trading and reveals the seed after the bell.
- Every client can replay the published order log and verify final equity to the cent.
- Private hints use ECDH P-256 and AES-GCM when the connected room transport is available.

## Game rules

- Four-minute round.
- Eight seats, with bots filling empty positions.
- $1 million starting cash per trader.
- Position, order-size, and open-order limits.
- Margin calls close positions at market.
- The last solvent trader—or richest trader at the bell—wins.

## Run locally

```bash
make serve
```

Open <http://localhost:8000>. No frontend build step is required.

## Verify it

Requires Node.js 22, Python 3.11+, and [uv](https://docs.astral.sh/uv/).

```bash
uv sync --dev
make test
```

The suite covers Python/JavaScript order-book parity, deterministic replay, forged logs, self-trade prevention, risk limits, margin calls, settlement, and news delivery.

## Repository map

```text
docs/       standalone browser game, exchange, networking, and UI
src/lob/    Python reference order book and market simulation
tests/js/   parity and deterministic game-engine tests
```

The game began as the interactive demonstration inside [`lob-market-making`](https://github.com/asp53826/lob-market-making). That repository remains the broader market-microstructure project; this repository is the standalone game.

## Multiplayer modes

- **Solo:** works everywhere; bots fill unused seats.
- **Same browser:** GitHub Pages tabs communicate through `BroadcastChannel`.
- **Across the internet:** requires a room/presence transport. Static GitHub Pages alone cannot provide a trusted multiplayer server.

## License

MIT
