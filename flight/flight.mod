/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Administrator
 * Creation Date: 2019年3月4日 at 下午3:11:08
 *********************************************/
{int} f =...;
{int} k = ...;
{int} j = ...;
{int} a = ...;
{int} F =...;

int P[f][k] =...;

/*
int J[f] =...;
int R[f] =...;
*/
int s[f] =...;
int l[f][j] =...;
int D[a] =...;
int A[a] =...;
int S[j] =...;
{int} t =asSet(1..30);
/*{int} F=asSet(1..10);


forall (f in 1..10){
  if(P[f][k+1]-P[f][k]<0)
    {N[f]=k[f]
    }   
    N[f]=4[f] 
}  
*/
 


int N[f];
execute {
  for(var i in f) 
     for(var m in k){
    
    if(P[i][m]==0) 
    N[i]=m-1;
    else N[i]=m;
  }

}

int J[f];
execute {
  for(var i in f) {
    J[i] = N[i]-1;
  }
}

int R[f][F];
execute {
 

  for(var i in f) {
     var m = 1;  
     for(var n in f)
      if(P[i][N[i]]==P[n][1]) 
      {          
         R[i][m]=n; 
         m++;
      }

  }
}

int start[a][f];
int p[a];
execute{
		for(var i in a){
			p[i] = 1;		
		}
		for(var i in f){
			for(var n in a){		
				if(P[i][1]==n){
				  start[n][p[n]]=i;
				  p[n]++;	
				  break;
				}	
	 
			}
	}		
}

int end[a][f];

execute{
		for(var i in a){
			p[i] = 1;		
		}
		for(var i in f){
			for(var n in a){			
			if(P[i][N[i]]==n){
			  end[n][p[n]]=i;
			  p[n]++;
			  break;	
			}	
		 }		 
		}
}

int K[j][f];
int area[j];
execute{
	for(var i in j){
		area[i] = 1;		
	}
	for(var l in k){
		for(var i in f){
			for(var n in j)		
				if(P[i][l]==n){
				  K[n][area[n]]=i;
				  area[n]++;		  
				  break;
				}	
			 
		}
	}
}

/*
int J[f]=2..N[f]-1;

forall (f in lines1)
  forall (F in lines1){
    if(1[F]=N[f]) 
      {R[f][F]=F 
      }
 }
 */
  
dvar int z[t] in 0..1;
dvar int+ w[1..11][1..32][1..5] in 0..1;
dvar int+ y[1..31] in 0..1;
dvar int+ x[1..11][1..11] in 0..1;

/*minimize 
    max (t in 1..30) t*(w[f][t+1][k]-w[f][t][k])-min (t in 1..30)t*(w[f][t+1][k]-w[f][t][k]);
*/    

minimize 
    sum(t in t)(t*(z[t+1]-z[t]))-sum(t in t)(t*(y[t+1]-y[t]));


subject to{
	forall(n in a)
	   forall(t in t)  
	        sum(b in f:start[n][b]>0 && b<=9) (w[start[n][b]][t+1][n]-w[start[n][b]][t][n])<=D[n];
 
 	
	  forall(n in a)
	    forall(t in t)
	        sum(f in f:end[n][f]>0) (w[end[n][f]][t+1][n]-w[end[n][f]][t][n])<=A[n];  
        
       forall(j in j)
         forall(t in t)
		   forall(ff in f)
	        sum(ff in f:K[j][ff]>0 && K[j][ff]<11) (w[K[j][ff]][t][j]-w[K[j][ff]][t][j+1])<=S[j]; 
       
       forall(f in f)
		forall(t in t)
	        forall(j in j) (w[f][t+l[f][j]][j+1]-w[f][t][j])<=0;    
	
	forall(f in f)
		forall(t in t)
	         forall(F in F)
	            if (R[f][F]>0) ((w[R[f][F]][t][1]-w[f][t-s[f]][N[f]])<=1-x[f][R[f][F]]);  
	
	forall(f in f)
	    sum(F in F) x[f][F]==1;   
	    
	forall(f in f)
	    forall(t in t)
	      forall(j in 2..J[f]) (w[f][t+1][j]-w[f][t][j])>=0;        
	      
   forall(f in f)
	    forall(t in t)
	      (y[t]-w[f][t][N[f]])>=0;  
	      
	forall(f in f)
	    forall(t in t)
	      (z[t]-w[f][t][N[f]])<=0;     
	      
	forall(t in t)
	      (y[t+1]-y[t])>=0;  
	      
	forall(t in t)
	      (z[t+1]-z[t])>=0; 
	      
}