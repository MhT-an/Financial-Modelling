function v = FD_eds_call(S0,X,r,T,sigma,q,N,I)
    % For Explicit schemes, N has to be chosen large enough to avoid
    % violating the monotinicity condition
    %

    Smax=3*X; % set maximum S to be three times the strike value
    dt=T/N;
    h=Smax/I;

    %
    VGrid=zeros(I+1,N+1); % finite difference grid
    ishift=1;

    % Boundary conditions
    VGrid(1,:)=0; % at S=0;
    VGrid(I+1,:)=(Smax-X)*exp(-r*(T-(0:dt:T)));

    % Terminal condition
    VGrid(:,N+1)=max((0:I)*h-X,0);

    i=(1:I-1)'; isq=i.^2;

    % Explicit Scheme II
    c=(0.5*sigma^2*isq+0.5*(r-q)*i)*dt/(1+r*dt);
    b=(1-sigma^2*isq*dt)/(1+r*dt);
    a=(0.5*sigma^2*isq-0.5*(r-q)*i)*dt/(1+r*dt);
    
    % Check on monotonicity
    % len01=length(find(a<0));
    % disp(['Coeff a, Of ',num2str(I-1), ' elements, ', num2str(len01),' violated the positivity condition.']);
    % len02=length(find(b<0));
    % disp(['Coeff b, Of ',num2str(I-1), ' elements, ', num2str(len02),' violated the positivity condition.']);
    % len03=length(find(c<0));
    % disp(['Coeff c, Of ',num2str(I-1), ' elements, ', num2str(len03),' violated the positivity condition.']);

    for n=N:-1:1 % backward time recursive
        VGrid(i+ishift,n)=a.*VGrid(i-1+ishift,n+1)+b.*VGrid(i+ishift,n+1)+c.*VGrid(i+1+ishift,n+1);
    end

    v=VGrid(round(S0/h)+ishift,1); % nearest point interpolation
    ExactValue=Ce(S0,X,r,T,sigma,q);
    disp(['At S0=',num2str(S0),' exact value=',num2str(ExactValue),' FD value=',num2str(v)]);

end

function y=Ce(S,X,r,t,sigma,q)
    d1=(log(S/X)+(r-q+sigma*sigma/2)*t)/sigma/sqrt(t);
    d2=d1-sigma*sqrt(t);
    y=S*exp(-q*t)*normcdf(d1)-X*exp(-r*t)*normcdf(d2);
end