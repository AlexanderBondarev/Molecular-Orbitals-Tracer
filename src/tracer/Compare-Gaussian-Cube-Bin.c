#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MaxS 4096
#define MaxN 80

long Xsize=80, Ysize=80, Zsize=80;
float X0, Y0, Z0;
float dX,dY,dZ;
long NAtom=0;
float V1[MaxN*MaxN*MaxN], V2[MaxN*MaxN*MaxN];

void fgetstr(FILE *f, char *s)
{
 long n=0;
 while(!feof(f)) 
  {
   s[n]=fgetc(f);
   if(s[n]=='\n') break; 
   if(s[n]!=EOF) n++;
   if(n>=MaxS) {s[n]='\0';break;}
  }
 s[n]='\0';
}

float Compare_Vol_Data(float *m1, float *m2) {
  long x,y,z;
  float Sum=0, v1, v2;

  for (x=0; x<Xsize; x++)
    for (y=0; y<Ysize; y++)
      for (z=0; z<Zsize; z++) {
        v1=m1[z*Xsize*Ysize + y*Xsize + x];
        v2=m2[z*Xsize*Ysize + y*Xsize + x];
        Sum+=fabs(v1*v1-v2*v2);
      }

//  printf("Delta = %f\n", Sum);
  printf("%f", Sum);
  return Sum;
}

int Read_Vol_Data(FILE *f, float *m) {
  long x,y,z;
  float v;

  for (x=0; x<Xsize; x++)
    for (y=0; y<Ysize; y++) { // printf("{%ld %ld}  ", x+1, y+1);
      for (z=0; z<Zsize; z++) {
        if (fscanf(f, "%f", &v) != 1) return -1; else m[z*Xsize*Ysize + y*Xsize + x]=v;
//        printf("%ld[%e] ", z+1, m[z*Xsize*Ysize + y*Xsize + x]);
      }
//      printf("\n");
    }

  return 0;
}

int Read_Gaussian_Cube(char *FName, float *m) {
  char s[MaxS];
  FILE *f;
  long n,i;
  float d;

  f=fopen(FName,"r"); if(f==NULL) { printf("File [%s] not exist\n", FName); return -1; }
  fgetstr(f,s);
  fgetstr(f,s);
  fscanf(f,"%ld",&n); NAtom=-n;
  fscanf(f,"%f",&X0); fscanf(f,"%f",&Y0); fscanf(f,"%f",&Z0);
//  printf("NAtom=%ld X0=%f Y0=%f Z0=%f\n", NAtom, X0, Y0, Z0);
  fscanf(f,"%ld",&Xsize); fscanf(f,"%f",&dX); fscanf(f,"%f",&d); fscanf(f,"%f",&d);
  fscanf(f,"%ld",&Ysize); fscanf(f,"%f",&d); fscanf(f,"%f",&dY); fscanf(f,"%f",&d);
  fscanf(f,"%ld",&Zsize); fscanf(f,"%f",&d); fscanf(f,"%f",&d); fscanf(f,"%f",&dZ);
//  printf("DIM=(%ld %ld %ld) d=(%f %f %f)\n", Xsize, Ysize, Zsize, dX, dY, dZ);
  fgetstr(f,s); // printf("[%s]\n", s);
  for(i=0; i<NAtom; i++) fgetstr(f,s);
  fgetstr(f,s); // printf("[%s]\n", s);
  Read_Vol_Data(f, m);
  fclose(f);
}

int Load_Gaussian_Cube_Bin(char *FName, float *m) {
  char s[MaxS];
  FILE *f;
  long n,i;
  float d;

  f=fopen(FName,"rb"); if(f==NULL) { printf("File [%s] not open\n", FName); return -1; }
  fread(m, sizeof(float), MaxN*MaxN*MaxN, f);
  fclose(f);
}

int main(int argc, char *argv[]) {
  Load_Gaussian_Cube_Bin(argv[1], V1);
  Load_Gaussian_Cube_Bin(argv[2], V2);
  Compare_Vol_Data(V1, V2);
}

