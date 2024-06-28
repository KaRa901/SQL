SET @vondatum = '2022-03-01';
SET @bisdatum = '2022-04-28';

SELECT rpos.id, rpos.rechnung, rg.belegnr, rg.kundennummer,

art.name_de, art.nummer AS 'EAN', rpos.menge, rpos.preis, round(SUM(rpos.menge * rpos.preis),2) AS 'VK Gesamt', prj.name, rg.datum, 
rg.kundennummer LIKE '10055' OR rg.kundennummer LIKE '10047' OR rg.kundennummer LIKE '10054' OR rg.kundennummer LIKE '10049' OR rg.kundennummer LIKE '10051' OR rg.kundennummer LIKE '10053' OR rg.kundennummer LIKE '10048'
AS 'Shopverkauf aus Zentrallager Yes/No' 
FROM rechnung_position rpos


LEFT JOIN artikel art ON rpos.artikel = art.id
LEFT JOIN rechnung rg ON rg.id = rpos.rechnung
LEFT JOIN projekt prj ON rg.projekt = prj.id
WHERE rg.datum BETWEEN @vondatum AND @bisdatum
AND art.nummer NOT LIKE '%x%'
AND art.nummer NOT LIKE '%-%'
AND art.nummer NOT LIKE '%-del%' 
AND art.nummer NOT LIKE 'porto_239'
AND art.nummer NOT LIKE 'porto_241'

GROUP BY rpos.id
