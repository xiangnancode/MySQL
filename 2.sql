select 
TICKET,
SIDE,
VOLUME * (OPEN_PRICE/2 + CLOSE_PRICE/2) /base_to_usd_rate AS profit_loss
from sample.trades
where (CLOSE_PRICE > 0) and SIDE = 'SELL'
union ALL
select
TICKET,
SIDE,
VOLUME * (OPEN_PRICE/2 + CLOSE_PRICE/2) /quote_to_usd_rate AS profit_loss
from sample.trades
where (CLOSE_PRICE > 0) and SIDE = 'BUY'
order by TICKET;
