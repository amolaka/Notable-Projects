
fls = list.files()
for(f in fls){
  temp = strsplit(f,split='[.]')
  if( temp[[1]][2]=='csv'){
    df = read.csv(f)
    write.csv(df,f, fileEncoding = 'utf-8')
  }
}
