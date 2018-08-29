-- insert secondary object to see all access per month over a year for certain door, wcb 8/29/18
SELECT
	datepart(
		YEAR,
		CONVERT (nvarchar(20), serverutc, 101)
	) AS [Year] --,datepart(month,CONVERT(nvarchar(20), serverutc, 101))
	,
	DATENAME(m, serverutc) AS [Month],
	COUNT (*) AS JournalEntries
FROM
	[SWHSystemJournal].[dbo].[JournalLog]
WHERE
	(
		serverUTC BETWEEN DATEADD(dd, - 365, GETutcDATE())
		AND getutcdate()
	)
AND messagetype = 'CardAdmitted'
AND secondaryObjectName IN ('Your Door Name Here')
GROUP BY
	datepart(
		YEAR,
		CONVERT (nvarchar(20), serverutc, 101)
	),
	datepart(
		MONTH,
		CONVERT (nvarchar(20), serverutc, 101)
	),
	DATENAME(m, serverutc)
ORDER BY
	datepart(
		YEAR,
		CONVERT (nvarchar(20), serverutc, 101)
	) ASC,
	datepart(
		MONTH,
		CONVERT (nvarchar(20), serverutc, 101)
	) ASC,
	DATENAME(m, serverutc) ASC