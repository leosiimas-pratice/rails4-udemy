def levantar_erro
  begin
    p ">>>>>>>> Antes do erro"
    File.open("abc.txt")
    p ">>>Depois do erro"
  rescue Errno::ENOENT
    p "O arquivo nao existe...."
  rescue Exception => e
    p ">>Pode dar erro #{e}"
  ensure
    p">>>>>>>Isso eh feito de qq forma!"
  end
end

levantar_erro
