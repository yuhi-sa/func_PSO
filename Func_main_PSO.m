%/////// <TCPSOパラメータ定義> /////////
ns=300;          % 粒子数
c1s=1;           % 自身の最良位置に対する重み
c2s=1;           % 全体の最良位置に対する重み
maxT=500;     % 繰り返し回数
D=2;             % 次元

%****************　[STEP1] 初期粒子群の発生 ********************************
            
ps = 0.5-rand(ns,2);  %初期粒子群発生 
ps(:,3) = 0;
ps_v = rand(ns,2);  
ps_best = ps; %ローカルベスト   
P_S_G(1,D+1) = 0; %グローバルベスト

f0 = figure;
plot(ps(:,1),ps(:,2),'o')
xlim([-0.5 0.5])
ylim([-0.5 0.5])

for count=1:maxT
%****************　[STEP2] 評価値計算 **************************************
            
    for t=1:ns
        ps(t,3) = 1/abs(ps(t,1))+abs(ps(t,2));
    end
               
%****************　[STEP3] 各粒子の最良位置の更新 ***************************
            
    for i=1:ns 
        if(ps(i,3) > ps_best(i,3))
            for j=1:D+1
               ps_best(i,j) = ps(i,j);
            end
        end
    end            
           
 %****************　[STEP4] 全体の最良位置の更新 ***************************
            
    for i=1:ns 
        if(ps(i,3) > P_S_G(1,3))
            for j=1:D+1
                P_S_G(i,j) = ps(i,j);
            end
        end 
    end
                        
 %****************　[STEP5] 各粒子の速度，位置を計算 ***************************     
            
    %パラメータ更新              
    for i=1:ns
        for j=1:D
            r1 = rand/100;
            r2 = rand/100;
            ps_v(i,j) = c1s*r1*(ps_best(i,j)-ps(i,j)) + c2s*r2*(P_S_G(1,j)-ps(i,j)); %速度更新
            ps(i,j) = ps(i,j) + ps_v(i,j); %位置更新
        end
    end

    if (mod(count,250)==0) %250更新ごとに図を表示
        f1 = figure;
        plot(ps(:,1),ps(:,2),'o')
        xlim([-0.5 0.5])
        ylim([-0.5 0.5])
    end
               
end