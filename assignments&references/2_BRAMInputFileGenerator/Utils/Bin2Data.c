#include<stdio.h>
#include<stdlib.h>

void bytesToHexstring(char* bytes,int bytelength,char *hexstring,int hexstrlength)
{
	char str2[16] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
	int i,j,b;
	char s1,s2;
	for (i=0,j=0;i<bytelength,j<hexstrlength;i++,j++) 
	{
		b = 0x0f&(bytes[i]>>4);
		s1 = str2[b];
		hexstring[j] = s1;    
		b = 0x0f & bytes[i];
		s2 = str2[b];
		j++;
		hexstring[j] = s2;    
	}
}

int main(int argc, char* argv[])
{
	char tmp[4];
	char str[4*2+1];
	if(argc!=3)
	{
		printf("Usage: ./BIN2BRAM BinFileName BRAMFileName\n");
		exit(-1);
	}
	FILE* fp1=fopen(argv[1],"rb");
	if(!fp1)
	{
		printf("File %s Doesn't Exist!\n",argv[1]);
		exit(-1);
	}
	FILE* fp2=fopen(argv[2],"wt");
	if(!fp2)
	{
		printf("Failed to open File %s!\n",argv[2]);
		exit(-1);
	}
	//
	fread(tmp+3,sizeof(char),1,fp1);
	fread(tmp+2,sizeof(char),1,fp1);
	fread(tmp+1,sizeof(char),1,fp1);
	fread(tmp,sizeof(char),1,fp1);	
	while(!feof(fp1))
	{
		//
		bytesToHexstring(tmp,1,str,2);
		bytesToHexstring(tmp+1,1,str+2,2);
		bytesToHexstring(tmp+2,1,str+4,2);
		bytesToHexstring(tmp+3,1,str+6,2);
		str[8] = 0;
		fprintf(fp2,"%s\n",str);
		//
		fread(tmp+3,sizeof(char),1,fp1);
		fread(tmp+2,sizeof(char),1,fp1);
		fread(tmp+1,sizeof(char),1,fp1);
		fread(tmp,sizeof(char),1,fp1);
	}
		
	fclose(fp1);
	fclose(fp2);
	return 0;
}
