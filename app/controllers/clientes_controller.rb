class ClientesController < ApplicationController
  respond_to? :js, :html

  @resultadoPositivoCliente = ""

  def self.getResultadoPositivoCliente
    @resultadoPositivoCliente
  end
  def self.setResultadoPositivoCliente valor
    @resultadoPositivoCliente = valor
  end

  def index
    @cliente = Cliente.new
  end

  def new
    @cliente = Cliente.new
  end

  def edit
    @cliente = Cliente.find(params[:id])
    @clientes = Cliente.listaClientes
    render 'clientes/edit'
  end

  def update
    @cliente = Cliente.find(params[:id])


    if @cliente.update(cliente_params)
      @@resultadoPositivoCliente = "Cliente Atualizado"
      redirect_to clientes_path
    else
      render 'clientes/index'
    end

  end

  def create
    @cliente = Cliente.new(cliente_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @cliente.tipo = 0
    @cliente.inativo = 0

    if @cliente.save
      @@resultadoPositivoCliente = "Cliente Salvo"
      redirect_to
    else
      render 'clientes/index'
    end
  end

  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.update(inativo: 1)
    @@resultadoPositivoCliente = "Cliente Deletado";
    redirect_to logins_index_path
  end

  private

  def cliente_params
    params.require(:cliente).permit(:nome, :identificador, :telefone, :celular, :email, :senha)
  end

end