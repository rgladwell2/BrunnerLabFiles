[sig, st, p] = load_bcidat('data/test001/testS001R138.dat');
t = double(st.SourceTime);
    ind = 1:length(t);
    boolArr = diff(double(t))<0;
    ind = ind(boolArr);
    maxT = t(boolArr);
    for n=1:length(maxT)
        t(ind(n)+1:end) = maxT(n)+t(ind(n)+1:end);
    end


it=1;
time=t(it);
finalv=size(t,1);
samp=p.SamplingRate.NumericValue;
while(it<finalv-(p.SampleBlockSize.NumericValue-1))
    for i=0:(p.SampleBlockSize.NumericValue-1)
        t(it)=time+(1000/samp)*i;
        it=it+1;
    end
time=t(it);
end
dataend=24190;
t=t(1:dataend);
dig4=st.DigitalInput4(1:dataend);
dig5=st.DigitalInput5(1:dataend);
rb=st.RTLightEvent(1:dataend);

% figure(1)
% plot(t, dig4)
% hold on
% plot(t,dig5)
% plot(t,rb)
% legend("RTBox TTL","TrigBox","RTBox Serial USB")
% xlabel("Time (ms)")
% ylabel("Activity State")
% title("Comparing Latency Times of Photodiode Responses")
% dig4v5=[];
% dig4vrb=[];
% y=1;
% while(y<size(t,1))
%     while(y<size(t,1)&&dig4(y)~=1)
%     y=y+1;
%     end
%     if(dig4(y)==1)
%         intsaver=y;
%         while(dig5(y)~=1)
%             y=y+1;
%         end
%         if(dig5(y)==1)
%             intsaver2=y;
%         end
%         y=intsaver;
%          while(rb(y)~=1)
%             y=y+1;
%         end
%         if(rb(y)==1)
%             intsaver3=y;
%         end
%         dig4v5(end+1)=(t(intsaver2)-t(intsaver));
%         dig4vrb(end+1)=(t(intsaver3)-t(intsaver));
%         while(dig4(y)~=0)
%             y=y+1;
%         end
%     end
% end
% 
% figure(2)
% histogram(dig4v5)
% title("Latency of TrigBox using RTBox TTL as Ground Truth")
% ylabel("Amount of Occurances")
% xlabel("Latency Time(ms)")
% SS=std(dig4v5);
% figure(3)
% histogram(dig4vrb)
% title("Latency of RTBox Serial USB using RTBox TTL as Ground Truth")
% ylabel("Amount of Occurances")
% xlabel("Latency Time(ms)")
% SS2=std(dig4vrb);


dig4time=[];
dig5time=[];
rbtime=[];
SC=st.StimulusCode(1:dataend);
y=1;
while(y<size(t,1))
    while(y<size(t,1)&&SC(y)~=2)
    y=y+1;
    end
    if(SC(y)==2)
        intsaver=y;


        while(dig4(y)~=1)
            y=y+1;
        end
        if(dig4(y)==1)
            intsaver2=y;
        end


        y=intsaver;
         while(rb(y)~=1)
            y=y+1;
        end
        if(rb(y)==1)
            intsaver3=y;
        end
        y=intsaver;


        while(dig5(y)~=1)
            y=y+1;
        end
        if(dig5(y)==1)
            intsaver4=y;
        end
        dig4time(end+1)=(t(intsaver2)-t(intsaver));
        dig5time(end+1)=(t(intsaver4)-t(intsaver));
        rbtime(end+1)=(t(intsaver3)-t(intsaver));
        while(SC(y)~=0)
            y=y+1;
        end
    end
end
figure(1)
histogram(dig4time)
title("RTBox TTL Latency from Onset of Stimulus")
ylabel("Amount of Occurances")
xlabel("Latency Time(ms)")
box off
figure(2)
histogram(dig5time)
title("TrigBox Latency from Onset of Stimulus")
ylabel("Amount of Occurances")
xlabel("Latency Time(ms)")
box off
figure(3)
histogram(rbtime)
title("RTBox Serial usb Latency from Onset of Stimulus")
ylabel("Amount of Occurances")
xlabel("Latency Time(ms)")

box off