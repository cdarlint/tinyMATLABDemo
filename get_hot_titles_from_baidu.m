%% Request to Open a WebPage in a CEF Browser
appwin=matlab.internal.webwindow('www.baidu.com');
appwin.PageLoadFinishedCallback=@(obj,src)pageLoaded(obj);
ready=false;
% show(appwin);
clear final
% c=0
while ~ready
    pause(0.1)
%     c=c+1
    drawnow
end
appwin.close();
clear appwin
final

function pageLoaded(obj)
rst=obj.executeJS("$('.title-content').map(function(){return [[$(this).find('.title-content-title').text(),$(this).attr('href')]]}).toArray()");
jd=jsondecode(rst);
hc=string(horzcat(jd{:}));
final=dictionary(hc(1,:),hc(2,:));
evalin('base','ready=true;');
assignin('base','final',final);
end