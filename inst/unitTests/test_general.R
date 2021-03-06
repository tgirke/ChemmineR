


test.formatConversions <- function() {
	message("test.formatConversions")

	data(sdfsample)

	smiles = sdf2smiles(sdfsample[1:10])
	sdfs = smiles2sdf(smiles)
	smiles2 = sdf2smiles(sdfs)

	checkEquals(smiles,smiles2)

}

test.genAPDescriptors <- function(){

	data(sdfsample)
	
	for(i in 1:100){
		sdf = sdfsample[[i]]
		desc = genAPDescriptors(sdf)
		#print(desc);

		oldDesc=ChemmineR:::.gen_atom_pair(ChemmineR:::SDF2apcmp(sdf))
                 
		#print(oldDesc);
		checkTrue(all(desc == oldDesc))
		#print(all(desc == oldDesc))
	}

}
test.propOB <- function() {
	data(sdfsample)
	p = propOB(sdfsample[1:5])
	print(p)
	#checkEquals(ncol(p),15)
	checkEquals(nrow(p),5)
   checkEquals(p$MW[2],MW(sdfsample[2])[[1]])

}
test.fingerprintOB <- function(){
	if(require(ChemmineOB)){
		data(sdfsample)
		fp = fingerprintOB(sdfsample[1:5],"FP2")
		print(fp)
		checkEquals(fptype(fp),"FP2")
	}
}
test.obmolRefs <- function() {
	data(sdfsample)
	if(require(ChemmineOB)){
		obmolRef = obmol(sdfsample[[1]])
		checkEquals(class(obmolRef),"_p_OpenBabel__OBMol")

		obmolRefs = obmol(sdfsample)
		checkEquals(class(obmolRefs),"list")
		checkEquals(class(obmolRefs[[2]]),"_p_OpenBabel__OBMol")
		checkEquals(length(sdfsample),length(obmolRefs))
	}else
		checkException(obmol(sdfsample[[1]]))

}
test.smartsSearchOB <- function(){
	data(sdfsample)
	rotableBonds = smartsSearchOB(sdfsample[1:5],"[!$(*#*)&!D1]-!@[!$(*#*)&!D1]",uniqueMatches=FALSE)
	print("rotable bonds: ")
	print(rotableBonds)
	print(sdfid(sdfsample[1:5]))
	checkEquals(as.vector(rotableBonds[1:5]),c(24,20,14,30,10))

}
