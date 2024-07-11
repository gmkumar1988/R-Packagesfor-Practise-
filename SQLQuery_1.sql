SELECT 
[Stock Item],
[Unit Price],
[Recommended Retail Price],
([Recommended Retail Price] - [Unit Price]/ [Unit Price]) as PctMarkup 
FROM dimStockItem
WHERE [WWI Stock Item ID] = 29