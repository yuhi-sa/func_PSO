%/////// <TCPSO�p�����[�^��`> /////////
ns=300;          % ���q��
c1s=1;           % ���g�̍ŗǈʒu�ɑ΂���d��
c2s=1;           % �S�̂̍ŗǈʒu�ɑ΂���d��
maxT=500;     % �J��Ԃ���
D=2;             % ����

%****************�@[STEP1] �������q�Q�̔��� ********************************
            
ps = 0.5-rand(ns,2);  %�������q�Q���� 
ps(:,3) = 0;
ps_v = rand(ns,2);  
ps_best = ps; %���[�J���x�X�g   
P_S_G(1,D+1) = 0; %�O���[�o���x�X�g

f0 = figure;
plot(ps(:,1),ps(:,2),'o')
xlim([-0.5 0.5])
ylim([-0.5 0.5])

for count=1:maxT
%****************�@[STEP2] �]���l�v�Z **************************************
            
    for t=1:ns
        ps(t,3) = 1/abs(ps(t,1))+abs(ps(t,2));
    end
               
%****************�@[STEP3] �e���q�̍ŗǈʒu�̍X�V ***************************
            
    for i=1:ns 
        if(ps(i,3) > ps_best(i,3))
            for j=1:D+1
               ps_best(i,j) = ps(i,j);
            end
        end
    end            
           
 %****************�@[STEP4] �S�̂̍ŗǈʒu�̍X�V ***************************
            
    for i=1:ns 
        if(ps(i,3) > P_S_G(1,3))
            for j=1:D+1
                P_S_G(i,j) = ps(i,j);
            end
        end 
    end
                        
 %****************�@[STEP5] �e���q�̑��x�C�ʒu���v�Z ***************************     
            
    %�p�����[�^�X�V              
    for i=1:ns
        for j=1:D
            r1 = rand/100;
            r2 = rand/100;
            ps_v(i,j) = c1s*r1*(ps_best(i,j)-ps(i,j)) + c2s*r2*(P_S_G(1,j)-ps(i,j)); %���x�X�V
            ps(i,j) = ps(i,j) + ps_v(i,j); %�ʒu�X�V
        end
    end

    if (mod(count,250)==0) %250�X�V���Ƃɐ}��\��
        f1 = figure;
        plot(ps(:,1),ps(:,2),'o')
        xlim([-0.5 0.5])
        ylim([-0.5 0.5])
    end
               
end