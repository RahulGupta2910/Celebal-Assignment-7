parameters{
	dateDash1 as string ("test default"),
	dateDash2Key as string ("this is date apart from file")
}
source(allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false,
	partitionRootPath: 'rawinput') ~> source1
source1 derive(filenameDate = $dateDash1,
		filenameDateKey = $dateDash2Key) ~> derivedColumn1
derivedColumn1 sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		CustomerID as string,
		Name as string,
		Location as string
	),
	truncate: true,
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> sink1