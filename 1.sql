select * from sample.trades
where (CLOSE_PRICE > 0)
order by TICKET;

select * from sample.trades
where (CLOSE_PRICE = 0)
order by TICKET;

