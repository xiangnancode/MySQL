select DAY, sum(USD_VOLUME)
FROM (
select 
TICKET,
DAYOFMONTH(CLOSE_TIME) AS DAY,
SIDE,
VOLUME * (OPEN_PRICE/2 + CLOSE_PRICE/2) /base_to_usd_rate AS USD_VOLUME
from sample.trades
where (CLOSE_PRICE > 0) and SIDE = 'SELL'
union ALL
select
TICKET,
DAYOFMONTH(CLOSE_TIME) AS DAY,
SIDE,
VOLUME * (OPEN_PRICE/2 + CLOSE_PRICE/2) /quote_to_usd_rate AS USD_VOLUME
from sample.trades
where (CLOSE_PRICE > 0) and SIDE = 'BUY'
UNION ALL
select
TICKET, 
DAYOFMONTH(roll_date) AS DAY,
SIDE,
VOLUME * ask /base_to_usd_rate AS USD_VOLUME
from sample.trades 
LEFT join sample.end_of_day_prices on sample.trades.SYMBOL = sample.end_of_day_prices.symbol
where CLOSE_PRICE = 0 and SIDE = 'SELL'
union ALL
select
TICKET,
DAYOFMONTH(roll_date) AS DAY,
SIDE,
VOLUME * bid /quote_to_usd_rate AS USD_VOLUME
from sample.trades
LEFT join sample.end_of_day_prices on sample.trades.SYMBOL = sample.end_of_day_prices.symbol
where CLOSE_PRICE = 0 and SIDE = 'BUY'
order by TICKET
)derivedTable
GROUP BY DAY;
