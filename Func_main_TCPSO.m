%/////// <TCPSOパラメータ定義> /////////
ns=300;          % スレーブ粒子数
nm=300;          % マスター粒子数
w=0.05;          %　慣性項
c1s=1;           % スレーブ群の最良位置に対する重み 
c2s=1;           % 全体の最良位置に対する重み
c1m=1;           % マスター群の最良位置に対する重み
c2m=1;           % スレーブ群の最良位置に対する重み
c3m=1;           % 全体の最良位置に対する重み

maxT=500;     % 繰り返し回数
D=2;             % 次元

%****************　[STEP1] 初期粒子群の発生 ********************************
 
%スレーブ粒子
sp = 0.5-rand(ns,2);  %初期粒子群発生 
sp(:,3) = 0;
sp_v = rand(ns,2);  
sp_best = sp; %ローカルベスト   

%マスター粒子
mp = 0.5-rand(nm,2);  %初期粒子群発生 
mp(:,3) = 0;
mp_v = rand(nm,2);  
mp_best = mp; %ローカルベスト   

P_S_G(1,D+1) = 0; %スレーブ粒子群全体のグローバルベスト
P_G(1,D+1) = 0; %粒子群全体のグローバルベスト

f0 = figure;
plot(sp(:,1),sp(:,2),'o')
hold on
plot(mp(:,1),mp(:,2),'o')
hold off
xlim([-0.5 0.5])
ylim([-0.5 0.5])

for count=1:maxT
%****************　[STEP2] 評価値計算 **************************************
            
    for t=1:ns
        sp(t,3) = 1/abs(sp(t,1))+abs(sp(t,2));
    end
    for t=1:ns
        mp(t,3) = 1/abs(mp(t,1))+abs(mp(t,2));
    end    
               
%****************　[STEP3] 各粒子の最良位置の更新 ***************************
            
    for i=1:ns 
        if(sp(i,3) > sp_best(i,3))
            for j=1:D+1
               sp_best(i,j) = sp(i,j);
            end
        end
    end 
    
    for i=1:ns 
        if(mp(i,3) > mp_best(i,3))
            for j=1:D+1
               mp_best(i,j) = mp(i,j);
            end
        end
    end   
           
 %****************　[STEP4] 全体の最良位置の更新 ***************************
    for i=1:ns %スレーブ群全体
        if(sp(i,3) > P_S_G(1,3))
            for j=1:D+1
                P_S_G(1,j) = sp(i,j);
            end
        end 
    end
    
    for i=1:nm %全体の最良位置
        if(mp(i,3) > P_G(1,3))
            for j=1:D+1
                P_G(1,j) = mp(i,j);
            end
         end 
    end
    
    if(P_S_G(1,3) > P_G(1,3))
        for j=1:D+1
            P_G(1,j) = P_S_G(1,j);
        end
    end        
                 
 %****************　[STEP5] 各粒子の速度，位置を計算 ***************************     
            
    %パラメータ更新
    for i=1:nm
        for j=1:D
            r1 = rand/100;
            r2 = rand/100;
            r3 = rand/100;
            mp_v(i,j) = w*mp_v(i,j) + c1m*r1*(mp_best(i,j)-mp(i,j)) + c2m*r2*(P_S_G(1,j)-mp(i,j)) + c3m*r3*(P_G(1,j) - mp(i,j)); %速度更新
            mp(i,j) = mp(i,j) + mp_v(i,j); %位置更新
        end
    end
    for i=1:ns
        for j=1:D
            r1 = rand/100;
            r2 = rand/100;
            sp_v(i,j) = c1s*r1*(sp_best(i,j)-sp(i,j)) + c2s*r2*(P_G(1,j)-sp(i,j)); %速度更新
            sp(i,j) = sp(i,j) + sp_v(i,j); %位置更新
        end
    end
    

    if (mod(count,250)==0) %250更新ごとに図を表示
        f1 = figure;
        plot(sp(:,1),sp(:,2),'o')
        hold on
        plot(mp(:,1),mp(:,2),'o')
        hold off
        xlim([-0.5 0.5])
        ylim([-0.5 0.5])
    end
       
end