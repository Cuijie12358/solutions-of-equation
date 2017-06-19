classdef dazuoye1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure                   % UI Figure
        Showfunction           matlab.ui.container.Panel          % 请输入多项式方...
        LabelNumericEditField  matlab.ui.control.Label            % 最高阶数
        Viewhighestx           matlab.ui.control.NumericEditField % [-Inf Inf]
        LabelEditField         matlab.ui.control.Label            % 方程系数
        Viewcoafficients       matlab.ui.control.EditField       
        Label                  matlab.ui.control.Label            % 方程：
        Viewfx                 matlab.ui.control.EditField       
        BildfxButton           matlab.ui.control.Button           % 生成
        solutions              matlab.ui.container.Panel          % 请选择求解方法
        Dichotomy              matlab.ui.container.Panel          % 二分法
        LabelNumericEditField2 matlab.ui.control.Label            % 求解区间
        Viewxa                 matlab.ui.control.NumericEditField % [-Inf Inf]
        LabelNumericEditField3 matlab.ui.control.Label            % ~
        Viewxb                 matlab.ui.control.NumericEditField % [-Inf Inf]
        LabelEditField2        matlab.ui.control.Label            % 方程的解
        Viewx                  matlab.ui.control.EditField       
        LabelNumericEditField4 matlab.ui.control.Label            % 运行次数
        Viewnumberd            matlab.ui.control.NumericEditField % [-Inf Inf]
        LabelNumericEditField5 matlab.ui.control.Label            % 自变量误差
        Viewex                 matlab.ui.control.NumericEditField % [-Inf Inf]
        Label2                 matlab.ui.control.Label            % 函数误差
        Viewef                 matlab.ui.control.NumericEditField % [-Inf Inf]
        DichotomyButton        matlab.ui.control.Button           % 求解
        Cutmethod              matlab.ui.container.Panel          % 割线法
        Label9                 matlab.ui.control.Label            % x0
        Viewx1                 matlab.ui.control.NumericEditField % [-Inf Inf]
        Label10                matlab.ui.control.Label            % x1
        Viewx2                 matlab.ui.control.NumericEditField % [-Inf Inf]
        Label11                matlab.ui.control.Label            % 方程的解
        Viewxnc                matlab.ui.control.EditField       
        Label12                matlab.ui.control.Label            % 运行次数
        Viewcountc             matlab.ui.control.NumericEditField % [-Inf Inf]
        Label13                matlab.ui.control.Label            % 自变量误差
        Viewexc                matlab.ui.control.NumericEditField % [-Inf Inf]
        Label14                matlab.ui.control.Label            % 函数误差
        Viewefc                matlab.ui.control.NumericEditField % [-Inf Inf]
        CutmethodButton        matlab.ui.control.Button           % 求解
        Newtonsmethod          matlab.ui.container.Panel          % 牛顿迭代法
        Label3                 matlab.ui.control.Label            % 初值
        Viewx0                 matlab.ui.control.NumericEditField % [-Inf Inf]
        Label5                 matlab.ui.control.Label            % 方程的解
        Viewxnd                matlab.ui.control.EditField       
        Label6                 matlab.ui.control.Label            % 运行次数
        Viewcountn             matlab.ui.control.NumericEditField % [-Inf Inf]
        Label7                 matlab.ui.control.Label            % 自变量误差
        Viewexn                matlab.ui.control.NumericEditField % [-Inf Inf]
        Label8                 matlab.ui.control.Label            % 函数误差
        Viewefn                matlab.ui.control.NumericEditField % [-Inf Inf]
        NewtonmethodButton     matlab.ui.control.Button           % 求解
        Plot                   matlab.ui.container.Panel          % 函数图形
        Viewplot               matlab.ui.control.UIAxes           % Title
        Viewname               matlab.ui.control.TextArea         %        
        Label15                matlab.ui.control.Label            % 1405051...
        Label17                matlab.ui.control.Label            % 1402014
    end


    properties (Access = private)
       fxc char % Description
    end


    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
        end

        % Viewcoafficients value changed function
        function GetViewcoafficients(app)

           
        end

        % BildfxButton button pushed function
        function BildfxButtonButtonPushed(app)
            valueC = app.Viewcoafficients.Value;
            highestx= app.Viewhighestx.Value;
            Astring = regexp(valueC,'\d*\.?\d*\+?\d*\-?\d*','match');%可以是任何数字
            Xsize = size(Astring);
            if (Xsize(2)-1)~=highestx;
                str = 'Can not show the function!';
                app.Viewfx.Value=str;
                return
            else 
            for i=1:1:Xsize(2)
                Numcoa(i) = str2num(Astring{i});
            end
                charx=num2str(highestx);
                app.fxc=['f(x) = ',Astring{1},'x^',charx];
                for i=2:1:Xsize(2)-1
                    charx=num2str(Xsize(2)-i);
                    if str2num(Astring{i}) < 0;
                        app.fxc = [app.fxc,Astring{i},'x^',charx];
                    else 
                        app.fxc = [app.fxc,'+',Astring{i},'x^',charx];
                    end
                end
                if str2num(Astring{Xsize(2)}) < 0;
                    app.fxc = [app.fxc,Astring{Xsize(2)}];
                else
                    app.fxc = [app.fxc,'+',Astring{Xsize(2)}];
                end
                app.Viewfx.Value=app.fxc;
            end 
            x=-10:0.1:10;
            y=Fn(Numcoa,x);
            plot(app.Viewplot,x,y);

          %  grid on

    
        end

        % DichotomyButton button pushed function
        function DichotomyButtonPushed(app)
           valueC = app.Viewcoafficients.Value;
           Astring = regexp(valueC,'\d*\.?\d*\+?\d*\-?\d*','match');%可以是任何数字            Xsize = size(Astring);           xn = 0.0;
           fxn = 0.0;
           xn = 0.0;
           xa=app.Viewxa.Value;
           xb=app.Viewxb.Value;
           ex = app.Viewex.Value;
           ef = app.Viewef.Value;
           Xsize = size(Astring);
           for i=1:1:Xsize(2)
                Numcoa(i) = str2num(Astring{i});
           end
           fa = Fn(Numcoa, xa);
           fb = Fn(Numcoa, xb);
           n = 0;
           flag = 0;
           a = xa;
           b = xb;
           if fa * fb > 0;
               flag = 1;
               str2 = 'Error!';
               app.Viewx.Value = str2;
               return
           end
           
           while flag == 0
               if flag 
                   break;
               end
               if fa == 0;
                   xn = xa;
                   n = n+1;
                   break;
               end
               if fb == 0;
                   xn = xb;
                   n = n+1;
                   break;
               end
               xn = (a + b) / 2;
               fxn = Fn(Numcoa, xn);
               if fxn == 0;
                   n = n+1;
                   break;
               end
               if fxn*fa < 0;
                   b = xn;
                   flag = (Judge(a, b, ex) || Judge(fxn, 0, ef));
                   n = n+1;
                elseif fxn*fb < 0;
                   a = xn;
                   flag = (Judge(a, b, ex) || Judge(fxn, 0, ef));
                   n = n+1;
               end
           end
           x = xa:0.01:xb;
           y = Fn(Numcoa,x);
           plot(app.Viewplot,x,y);
           app.Viewx.Value = num2str(xn);
           app.Viewnumberd.Value = n;
  
    
        end

        % NewtonmethodButton button pushed function
        function NewtonmethodButtonPushed(app)
	    valueC = app.Viewcoafficients.Value;
            Astring = regexp(valueC,'\d*\.?\d*\+?\d*\-?\d*','match');%可以是任何数字
            Xsize = size(Astring);
            ex = app.Viewexn.Value;
            ef = app.Viewefn.Value;
            x0 = app.Viewx0.Value;
            xa = x0;
            for i=1:1:Xsize(2)
                Numcoa(i) = str2num(Astring{i});
            end
	    n = 1; flagn = 0;
	    Dnumcoa = Derivative(Numcoa);
	    fn = Fn(Numcoa, x0);
	    dfn = Fn(Dnumcoa, x0);
            if abs(fn) < ef;
                flagn = 1;
                xn = x0;
                n = 0;
            end
	    while flagn == 0
                if flagn ~= 0;
                    break;
                end

         
		if dfn == 0;
		    strn = '导数为零';
                    app.Viewxnd.Value = strn;
	            return
		end
		xn = x0 - fn / dfn;
		fn = Fn(Numcoa, xn);
		dfn = Fn(Dnumcoa, xn);
		flagn = (Judge(xn, x0, ex) || Judge(fn, 0, ef));
		x0 = xn;
                n = n+1;
		if (n > 3000)
		    strn = '迭代失败';
		    app.Viewxnd.Value = strn;
                    return
		end
 	    end
            xl = [xa,xn];
            x = min(xl):0.001:max(xl);
            y = Fn(Numcoa,x);
            plot(app.Viewplot,x,y);
    
	    app.Viewxnd.Value = num2str(xn);
            app.Viewcountn.Value = n;
     
        end

        % CutmethodButton button pushed function
        function CutmethodButtonPushed(app)
	    valueC = app.Viewcoafficients.Value;
            Astring = regexp(valueC,'\d*\.?\d*\+?\d*\-?\d*','match');%可以是任何数字
            Xsize = size(Astring);
            ex = app.Viewexc.Value;
            ef = app.Viewefc.Value;
            x1 = app.Viewx1.Value; 
            x2 = app.Viewx2.Value;
            xa = x1;
            n = 1;flagc = 0;
            for i=1:1:Xsize(2)
                Numcoa(i) = str2num(Astring{i});
            end
	    f1 = Fn(Numcoa, x1);
	    f2 = Fn(Numcoa, x2);
            if abs(f1) < ef;
	        flagc = 1;
                xn = x1;
            end
            if abs(f1) < ef;
	        flagc = 1;
                xn = x2;
            end
            if Judge(x1, x2, ex);
	        flagc = 1;
                xn = x1;
            end
            while flagc == 0
                 if flagc ~=0;
                     break;
                 end
		xn = x2 - f2*(x2 - x1) / (f2 - f1);
		fn = Fn(Numcoa, xn);
		flagc = (Judge(xn, x2, ex) || Judge(fn, 0, ef));
		x1 = x2;
		x2 = xn;
                f1 = f2;
                f2 = fn;
                n = n + 1;
		if n > 3000;
                    strc = '迭代失败';
                    app.Viewxnc.Value = strc;
		    return
		end
            end
            xl = [xa,xn];
            x = min(xl):0.001:max(xl);
            y = Fn(Numcoa,x);
            plot(app.Viewplot,x,y);
 
 
            app.Viewxnc.Value = num2str(xn);
            app.Viewcountc.Value = n;
  
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 706 616];
            app.UIFigure.Name = 'UI Figure';
            setAutoResize(app, app.UIFigure, true)

            % Create Showfunction
            app.Showfunction = uipanel(app.UIFigure);
            app.Showfunction.BorderType = 'line';
            app.Showfunction.Title = '请输入多项式方程的参数';
            app.Showfunction.FontName = 'Helvetica';
            app.Showfunction.FontUnits = 'pixels';
            app.Showfunction.FontSize = 12;
            app.Showfunction.Units = 'pixels';
            app.Showfunction.Position = [10 503 687 105];

            % Create LabelNumericEditField
            app.LabelNumericEditField = uilabel(app.Showfunction);
            app.LabelNumericEditField.HorizontalAlignment = 'right';
            app.LabelNumericEditField.Position = [43 52 48 15];
            app.LabelNumericEditField.Text = '最高阶数';

            % Create Viewhighestx
            app.Viewhighestx = uieditfield(app.Showfunction, 'numeric');
            app.Viewhighestx.Position = [106 48 100 22];

            % Create LabelEditField
            app.LabelEditField = uilabel(app.Showfunction);
            app.LabelEditField.HorizontalAlignment = 'right';
            app.LabelEditField.Position = [214 48 48 15];
            app.LabelEditField.Text = '方程系数';

            % Create Viewcoafficients
            app.Viewcoafficients = uieditfield(app.Showfunction, 'text');
            app.Viewcoafficients.ValueChangedFcn = createCallbackFcn(app, @GetViewcoafficients);
            app.Viewcoafficients.Position = [277 48 292 22];

            % Create Label
            app.Label = uilabel(app.Showfunction);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [55 10 36 15];
            app.Label.Text = '方程：';

            % Create Viewfx
            app.Viewfx = uieditfield(app.Showfunction, 'text');
            app.Viewfx.Position = [106 10 540 22];

            % Create BildfxButton
            app.BildfxButton = uibutton(app.Showfunction, 'push');
            app.BildfxButton.ButtonPushedFcn = createCallbackFcn(app, @BildfxButtonButtonPushed);
            app.BildfxButton.Position = [589 48 57 22];
            app.BildfxButton.Text = '生成';

            % Create solutions
            app.solutions = uipanel(app.UIFigure);
            app.solutions.BorderType = 'line';
            app.solutions.Title = '请选择求解方法';
            app.solutions.FontName = 'Helvetica';
            app.solutions.FontUnits = 'pixels';
            app.solutions.FontSize = 12;
            app.solutions.Units = 'pixels';
            app.solutions.Position = [10 8 353 487];

            % Create Dichotomy
            app.Dichotomy = uipanel(app.solutions);
            app.Dichotomy.BorderType = 'line';
            app.Dichotomy.Title = '二分法';
            app.Dichotomy.FontName = 'Helvetica';
            app.Dichotomy.FontUnits = 'pixels';
            app.Dichotomy.FontSize = 12;
            app.Dichotomy.Units = 'pixels';
            app.Dichotomy.Position = [5 311 341 145];

            % Create LabelNumericEditField2
            app.LabelNumericEditField2 = uilabel(app.Dichotomy);
            app.LabelNumericEditField2.HorizontalAlignment = 'right';
            app.LabelNumericEditField2.Position = [10 88 48 15];
            app.LabelNumericEditField2.Text = '求解区间';

            % Create Viewxa
            app.Viewxa = uieditfield(app.Dichotomy, 'numeric');
            app.Viewxa.Position = [73 84 41 22];

            % Create LabelNumericEditField3
            app.LabelNumericEditField3 = uilabel(app.Dichotomy);
            app.LabelNumericEditField3.HorizontalAlignment = 'right';
            app.LabelNumericEditField3.Position = [113 88 20 15];
            app.LabelNumericEditField3.Text = '~';

            % Create Viewxb
            app.Viewxb = uieditfield(app.Dichotomy, 'numeric');
            app.Viewxb.Position = [138 84 43 22];

            % Create LabelEditField2
            app.LabelEditField2 = uilabel(app.Dichotomy);
            app.LabelEditField2.HorizontalAlignment = 'right';
            app.LabelEditField2.Position = [11 15 48 15];
            app.LabelEditField2.Text = '方程的解';

            % Create Viewx
            app.Viewx = uieditfield(app.Dichotomy, 'text');
            app.Viewx.Position = [74 11 100 22];

            % Create LabelNumericEditField4
            app.LabelNumericEditField4 = uilabel(app.Dichotomy);
            app.LabelNumericEditField4.HorizontalAlignment = 'right';
            app.LabelNumericEditField4.Position = [222 15 48 15];
            app.LabelNumericEditField4.Text = '运行次数';

            % Create Viewnumberd
            app.Viewnumberd = uieditfield(app.Dichotomy, 'numeric');
            app.Viewnumberd.Position = [285 11 43 22];

            % Create LabelNumericEditField5
            app.LabelNumericEditField5 = uilabel(app.Dichotomy);
            app.LabelNumericEditField5.HorizontalAlignment = 'right';
            app.LabelNumericEditField5.Position = [10 53 60 15];
            app.LabelNumericEditField5.Text = '自变量误差';

            % Create Viewex
            app.Viewex = uieditfield(app.Dichotomy, 'numeric');
            app.Viewex.Position = [74 49 82 22];

            % Create Label2
            app.Label2 = uilabel(app.Dichotomy);
            app.Label2.HorizontalAlignment = 'right';
            app.Label2.Position = [184 53 59 15];
            app.Label2.Text = '函数误差';

            % Create Viewef
            app.Viewef = uieditfield(app.Dichotomy, 'numeric');
            app.Viewef.Position = [242 49 88 22];

            % Create DichotomyButton
            app.DichotomyButton = uibutton(app.Dichotomy, 'push');
            app.DichotomyButton.ButtonPushedFcn = createCallbackFcn(app, @DichotomyButtonPushed);
            app.DichotomyButton.Position = [230 84 100 22];
            app.DichotomyButton.Text = '求解';

            % Create Cutmethod
            app.Cutmethod = uipanel(app.solutions);
            app.Cutmethod.BorderType = 'line';
            app.Cutmethod.Title = '割线法';
            app.Cutmethod.FontName = 'Helvetica';
            app.Cutmethod.FontUnits = 'pixels';
            app.Cutmethod.FontSize = 12;
            app.Cutmethod.Units = 'pixels';
            app.Cutmethod.Position = [6 4 340 145];

            % Create Label9
            app.Label9 = uilabel(app.Cutmethod);
            app.Label9.HorizontalAlignment = 'right';
            app.Label9.Position = [38 88 20 15];
            app.Label9.Text = 'x0';

            % Create Viewx1
            app.Viewx1 = uieditfield(app.Cutmethod, 'numeric');
            app.Viewx1.Position = [73 84 41 22];

            % Create Label10
            app.Label10 = uilabel(app.Cutmethod);
            app.Label10.HorizontalAlignment = 'right';
            app.Label10.Position = [118 88 20 15];
            app.Label10.Text = 'x1';

            % Create Viewx2
            app.Viewx2 = uieditfield(app.Cutmethod, 'numeric');
            app.Viewx2.Position = [143 84 43 22];

            % Create Label11
            app.Label11 = uilabel(app.Cutmethod);
            app.Label11.HorizontalAlignment = 'right';
            app.Label11.Position = [11 15 48 15];
            app.Label11.Text = '方程的解';

            % Create Viewxnc
            app.Viewxnc = uieditfield(app.Cutmethod, 'text');
            app.Viewxnc.Position = [74 11 100 22];

            % Create Label12
            app.Label12 = uilabel(app.Cutmethod);
            app.Label12.HorizontalAlignment = 'right';
            app.Label12.Position = [223 12 48 15];
            app.Label12.Text = '运行次数';

            % Create Viewcountc
            app.Viewcountc = uieditfield(app.Cutmethod, 'numeric');
            app.Viewcountc.Position = [286 8 43 22];

            % Create Label13
            app.Label13 = uilabel(app.Cutmethod);
            app.Label13.HorizontalAlignment = 'right';
            app.Label13.Position = [10 53 60 15];
            app.Label13.Text = '自变量误差';

            % Create Viewexc
            app.Viewexc = uieditfield(app.Cutmethod, 'numeric');
            app.Viewexc.Position = [74 49 82 22];

            % Create Label14
            app.Label14 = uilabel(app.Cutmethod);
            app.Label14.HorizontalAlignment = 'right';
            app.Label14.Position = [184 53 59 15];
            app.Label14.Text = '函数误差';

            % Create Viewefc
            app.Viewefc = uieditfield(app.Cutmethod, 'numeric');
            app.Viewefc.Position = [242 49 88 22];

            % Create CutmethodButton
            app.CutmethodButton = uibutton(app.Cutmethod, 'push');
            app.CutmethodButton.ButtonPushedFcn = createCallbackFcn(app, @CutmethodButtonPushed);
            app.CutmethodButton.Position = [229 84 100 22];
            app.CutmethodButton.Text = '求解';

            % Create Newtonsmethod
            app.Newtonsmethod = uipanel(app.solutions);
            app.Newtonsmethod.BorderType = 'line';
            app.Newtonsmethod.Title = '牛顿迭代法';
            app.Newtonsmethod.FontName = 'Helvetica';
            app.Newtonsmethod.FontUnits = 'pixels';
            app.Newtonsmethod.FontSize = 12;
            app.Newtonsmethod.Units = 'pixels';
            app.Newtonsmethod.Position = [5 158 341 145];

            % Create Label3
            app.Label3 = uilabel(app.Newtonsmethod);
            app.Label3.HorizontalAlignment = 'right';
            app.Label3.Position = [34 88 24 15];
            app.Label3.Text = '初值';

            % Create Viewx0
            app.Viewx0 = uieditfield(app.Newtonsmethod, 'numeric');
            app.Viewx0.Position = [73 84 41 22];

            % Create Label5
            app.Label5 = uilabel(app.Newtonsmethod);
            app.Label5.HorizontalAlignment = 'right';
            app.Label5.Position = [11 15 48 15];
            app.Label5.Text = '方程的解';

            % Create Viewxnd
            app.Viewxnd = uieditfield(app.Newtonsmethod, 'text');
            app.Viewxnd.Position = [74 11 100 22];

            % Create Label6
            app.Label6 = uilabel(app.Newtonsmethod);
            app.Label6.HorizontalAlignment = 'right';
            app.Label6.Position = [224 15 48 15];
            app.Label6.Text = '运行次数';

            % Create Viewcountn
            app.Viewcountn = uieditfield(app.Newtonsmethod, 'numeric');
            app.Viewcountn.Position = [287 11 43 22];

            % Create Label7
            app.Label7 = uilabel(app.Newtonsmethod);
            app.Label7.HorizontalAlignment = 'right';
            app.Label7.Position = [10 53 60 15];
            app.Label7.Text = '自变量误差';

            % Create Viewexn
            app.Viewexn = uieditfield(app.Newtonsmethod, 'numeric');
            app.Viewexn.Position = [74 49 82 22];

            % Create Label8
            app.Label8 = uilabel(app.Newtonsmethod);
            app.Label8.HorizontalAlignment = 'right';
            app.Label8.Position = [184 53 59 15];
            app.Label8.Text = '函数误差';

            % Create Viewefn
            app.Viewefn = uieditfield(app.Newtonsmethod, 'numeric');
            app.Viewefn.Position = [242 49 88 22];

            % Create NewtonmethodButton
            app.NewtonmethodButton = uibutton(app.Newtonsmethod, 'push');
            app.NewtonmethodButton.ButtonPushedFcn = createCallbackFcn(app, @NewtonmethodButtonPushed);
            app.NewtonmethodButton.Position = [230 84 100 22];
            app.NewtonmethodButton.Text = '求解';

            % Create Plot
            app.Plot = uipanel(app.UIFigure);
            app.Plot.BorderType = 'line';
            app.Plot.Title = '函数图形';
            app.Plot.FontName = 'Helvetica';
            app.Plot.FontUnits = 'pixels';
            app.Plot.FontSize = 12;
            app.Plot.Units = 'pixels';
            app.Plot.Position = [379 157 317 336];

            % Create Viewplot
            app.Viewplot = uiaxes(app.Plot);
            title(app.Viewplot, 'Title');
            xlabel(app.Viewplot, 'X');
            ylabel(app.Viewplot, 'Y');
            app.Viewplot.Box = 'on';
            app.Viewplot.XGrid = 'on';
            app.Viewplot.YGrid = 'on';
            app.Viewplot.Position = [3 14 309 298];

            % Create Viewname
            app.Viewname = uitextarea(app.UIFigure);
            app.Viewname.Position = [379 13 318 136];
            app.Viewname.Value = {'       '; '          ______                     _____'; '        /                                        / '; '       /                               /        /      /'; '      /                                        /            ____'; '     /               /           /   /        /     /     /          '; '    /               /           /   /        /     /     /____ '; '   /               /           /   /        /     /     / '; '   \______ \____ /   /   \ _/     /      \____'};

            % Create Label15
            app.Label15 = uilabel(app.UIFigure);
            app.Label15.Position = [588 111 77 15];
            app.Label15.Text = '14050510030';

            % Create Label17
            app.Label17 = uilabel(app.UIFigure);
            app.Label17.Position = [628 88 49 15];
            app.Label17.Text = '1402014';
        end
    end

    methods (Access = public)

        % Construct app
        function app = dazuoye1()

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end