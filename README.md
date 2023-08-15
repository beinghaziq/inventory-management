# Inventory Management

- All items have a `sell_by` value which denotes the number of days we have left to sell the item before it expires
- All items have a `price` value which denotes how much the item costs
- At the end of each day our system adjusts both values for every item
- Once the sell by date has passed, `price` decreases twice as fast
- The `price` of an item is never negative
- **Fine Art** actually increases in `price` the older it gets
  - And, similar to normal items, **Fine Art** increases in `price` twice as fast once the sell by date has passed
- **Gold Coins**, being an hard asset, never have to be sold and they never decrease in `price`
- The `price` of an item is never more than 50. Except for **Gold Coins**. They are so valuable that their `price` is 80
- **Concert Tickets** increase in `price` the closer `sell_by` gets to zero:
  - `price` increases by 2 when there are 10 days or less and by 3 when there are 5 days or less
  - `price` drops to 0 after the concert


