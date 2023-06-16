// Função para atualizar o jogo e lidar com a lógica de ataque
function atualizarJogo() {
    contexto.clearRect(0, 0, canvas.width, canvas.height);

    // Renderizar personagem
    contexto.drawImage(personagem.img, personagem.x, personagem.y);

    // Renderizar adversário
    contexto.drawImage(adversario.img, adversario.x, adversario.y);

    // Renderizar barras de vida e energia
    renderizarBarraVida(personagem, 10, 10, "green");
    renderizarBarraVida(adversario, canvas.width - 110, 10, "red");
    renderizarBarraEnergia(personagem, 10, 30, "blue");
    renderizarBarraEnergia(adversario, canvas.width - 110, 30, "blue");

    // Renderizar pontos
    renderizarPontos(personagem, 10, 60);

    // Lógica de ataque
    if (personagem.x < adversario.x + adversario.img.width &&
        personagem.x + personagem.img.width > adversario.x &&
        personagem.y < adversario.y + adversario.img.height &&
        personagem.y + personagem.img.height > adversario.y) {
        // Personagens colidiram, aplicar dano
        personagem.vida -= 10;
        adversario.vida -= 10;

        // Verificar se algum personagem foi derrotado
        if (personagem.vida <= 0) {
            // Personagem derrotado, encerrar jogo
            encerrarJogo(adversarioSelecionado);
        } else if (adversario.vida <= 0) {
            // Adversário derrotado, incrementar pontos e reiniciar o jogo
            personagem.pontos += 100;
            reiniciarJogo();
        }
    }

    requestAnimationFrame(atualizarJogo);
}

// Função para encerrar o jogo e exibir mensagem de derrota
function encerrarJogo(personagemDerrotado) {
    contexto.clearRect(0, 0, canvas.width, canvas.height);
    contexto.font = "40px Arial";
    contexto.fillStyle = "red";
    contexto.fillText(`Você foi derrotado por ${personagemDerrotado}!`, canvas.width / 2 - 250, canvas.height / 2);
}

// Função para reiniciar o jogo
function reiniciarJogo() {
    // Redefinir posições e valores dos personagens
    personagem.x = personagemSelecionado.x;
    personagem.y = personagemSelecionado.y;
    personagem.vida = 100;
    personagem.energia = 100;

    adversario.x = adversarioSelecionado.x;
    adversario.y = adversarioSelecionado.y;
    adversario.vida = 100;
    adversario.energia = 100;

    // Atualizar tela de jogo
    atualizarJogo();
}
