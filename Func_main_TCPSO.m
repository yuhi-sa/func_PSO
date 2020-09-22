%/////// <TCPSO�p�����[�^��`> /////////
ns=300;          % �X���[�u���q��
nm=300;          % �}�X�^�[���q��
w=0.05;          %�@������
c1s=1;           % �X���[�u�Q�̍ŗǈʒu�ɑ΂���d�� 
c2s=1;           % �S�̂̍ŗǈʒu�ɑ΂���d��
c1m=1;           % �}�X�^�[�Q�̍ŗǈʒu�ɑ΂���d��
c2m=1;           % �X���[�u�Q�̍ŗǈʒu�ɑ΂���d��
c3m=1;           % �S�̂̍ŗǈʒu�ɑ΂���d��

maxT=500;     % �J��Ԃ���
D=2;             % ����

%****************�@[STEP1] �������q�Q�̔��� ********************************
 
%�X���[�u���q
sp = 0.5-rand(ns,2);  %�������q�Q���� 
sp(:,3) = 0;
sp_v = rand(ns,2);  
sp_best = sp; %���[�J���x�X�g   

%�}�X�^�[���q
mp = 0.5-rand(nm,2);  %�������q�Q���� 
mp(:,3) = 0;
mp_v = rand(nm,2);  
mp_best = mp; %���[�J���x�X�g   

P_S_G(1,D+1) = 0; %�X���[�u���q�Q�S�̂̃O���[�o���x�X�g
P_G(1,D+1) = 0; %���q�Q�S�̂̃O���[�o���x�X�g

f0 = figure;
plot(sp(:,1),sp(:,2),'o')
hold on
plot(mp(:,1),mp(:,2),'o')
hold off
xlim([-0.5 0.5])
ylim([-0.5 0.5])

for count=1:maxT
%****************�@[STEP2] �]���l�v�Z **************************************
            
    for t=1:ns
        sp(t,3) = 1/abs(sp(t,1))+abs(sp(t,2));
    end
    for t=1:ns
        mp(t,3) = 1/abs(mp(t,1))+abs(mp(t,2));
    end    
               
%****************�@[STEP3] �e���q�̍ŗǈʒu�̍X�V ***************************
            
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
           
 %****************�@[STEP4] �S�̂̍ŗǈʒu�̍X�V ***************************
    for i=1:ns %�X���[�u�Q�S��
        if(sp(i,3) > P_S_G(1,3))
            for j=1:D+1
                P_S_G(1,j) = sp(i,j);
            end
        end 
    end
    
    for i=1:nm %�S�̂̍ŗǈʒu
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
                 
 %****************�@[STEP5] �e���q�̑��x�C�ʒu���v�Z ***************************     
            
    %�p�����[�^�X�V
    for i=1:nm
        for j=1:D
            r1 = rand/100;
            r2 = rand/100;
            r3 = rand/100;
            mp_v(i,j) = w*mp_v(i,j) + c1m*r1*(mp_best(i,j)-mp(i,j)) + c2m*r2*(P_S_G(1,j)-mp(i,j)) + c3m*r3*(P_G(1,j) - mp(i,j)); %���x�X�V
            mp(i,j) = mp(i,j) + mp_v(i,j); %�ʒu�X�V
        end
    end
    for i=1:ns
        for j=1:D
            r1 = rand/100;
            r2 = rand/100;
            sp_v(i,j) = c1s*r1*(sp_best(i,j)-sp(i,j)) + c2s*r2*(P_G(1,j)-sp(i,j)); %���x�X�V
            sp(i,j) = sp(i,j) + sp_v(i,j); %�ʒu�X�V
        end
    end
    

    if (mod(count,250)==0) %250�X�V���Ƃɐ}��\��
        f1 = figure;
        plot(sp(:,1),sp(:,2),'o')
        hold on
        plot(mp(:,1),mp(:,2),'o')
        hold off
        xlim([-0.5 0.5])
        ylim([-0.5 0.5])
    end
       
end