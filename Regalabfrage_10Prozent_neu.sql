SELECT rpos.artikel, rpos.rechnung, ROUND(SUM(rpos.menge),0) AS 'Menge Gesamt', ROUND(lpi.menge,0) AS 'Bestand aktuell', 
0.1*ROUND(SUM(rpos.menge),0)+0.1*ROUND(lpi.menge,0) AS '10 Prozent von altem Bestand',

	CASE WHEN ROUND(SUM(rpos.menge),0) <= 0.1*ROUND(SUM(rpos.menge),0)+0.1*ROUND(lpi.menge,0)
		THEN '1'
		ELSE '0'
	END AS 'Kleiner_Prozent',

art.nummer, art.name_de, art.hersteller, lp.kurzbezeichnung

FROM rechnung_position rpos
LEFT JOIN artikel art ON art.id = rpos.artikel 
LEFT JOIN rechnung rg ON rg.id = rpos.rechnung
LEFT JOIN lager_platz_inhalt lpi ON art.id = lpi.artikel
LEFT JOIN lager_platz lp ON lpi.lager_platz = lp.id
WHERE rg.datum BETWEEN '2022-01-20' AND '2022-03-21'
AND lp.lager = 1 
AND art.intern_gesperrt = 0
AND lp.kurzbezeichnung LIKE '19%'
GROUP BY rpos.artikel
ORDER BY Kleiner_Prozent