select
TICKET, 
SIDE,
VOLUME * (OPEN_PRICE/2 + ask/2) /base_to_usd_rate AS profit_loss
from sample.trades 
LEFT join sample.end_of_day_prices on sample.trades.SYMBOL = sample.end_of_day_prices.symbol
where CLOSE_PRICE = 0 and SIDE = 'SELL'
union ALL
select
TICKET,
SIDE,
VOLUME * (OPEN_PRICE/2 + bid/2) /quote_to_usd_rate AS profit_loss
from sample.trades
LEFT join sample.end_of_day_prices on sample.trades.SYMBOL = sample.end_of_day_prices.symbol
where CLOSE_PRICE = 0 and SIDE = 'BUY'
order by TICKET;
