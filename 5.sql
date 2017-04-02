select DAY, sum(profit_loss)
FROM (
select
TICKET, 
DAYOFMONTH(roll_date) AS DAY,
SIDE,
VOLUME * ask / base_to_usd_rate AS profit_loss
from sample.trades 
LEFT join sample.end_of_day_prices on sample.trades.SYMBOL = sample.end_of_day_prices.symbol
where CLOSE_PRICE = 0 and SIDE = 'SELL'
union ALL
select
TICKET,
DAYOFMONTH(roll_date) AS DAY,
SIDE,
-VOLUME * bid /quote_to_usd_rate AS profit_loss
from sample.trades
LEFT join sample.end_of_day_prices on sample.trades.SYMBOL = sample.end_of_day_prices.symbol
where CLOSE_PRICE = 0 and SIDE = 'BUY'
order by TICKET
)derivedTable
GROUP BY DAY;
