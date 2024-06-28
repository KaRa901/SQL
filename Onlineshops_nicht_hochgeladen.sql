SELECT art.nummer, art.name_de, art.hersteller, ao.shop, adr.name AS 'Lieferant', lp.kurzbezeichnung AS Lagerplatz, round(lpi.menge,0) AS 'Menge', 
round(art.inventurek,2) AS Inventurwert, lpi.logdatei AS letzebewegung

FROM lager_platz_inhalt lpi
LEFT JOIN artikel art ON lpi.artikel = art.id
LEFT JOIN lager_platz lp ON lpi.lager_platz = lp.id
LEFT JOIN adresse adr ON art.adresse = adr.id
LEFT JOIN artikel_onlineshops ao ON art.id = ao.artikel

WHERE lp.lager = 1 
AND art.stueckliste <> 1
AND art.gesperrt <> 1
AND art.id not in (select ao.artikel from artikel_onlineshops ao where ao.shop= "9" )
AND art.nummer NOT LIKE '%-del%'
AND art.nummer NOT LIKE '%x%'
AND art.nummer NOT LIKE 'TEST1' 
ORDER BY art.hersteller