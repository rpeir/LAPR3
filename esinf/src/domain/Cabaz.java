package domain;

import java.awt.*;
import java.util.ArrayList;

public class Cabaz {

        private String clienteProdutorEmpresa;

        private int diaDeProducao;

        private ArrayList<Float> produtos;

        public Cabaz(String clienteProdutorEmpresa, int diaDeProducao, ArrayList<Float> produtos) {
            this.clienteProdutorEmpresa = clienteProdutorEmpresa;
            this.diaDeProducao = diaDeProducao;
            this.produtos = produtos;
        }

        public ArrayList<Float> getProdutos() {
            return produtos;
        }

        public String getClienteProdutor() {
            return clienteProdutorEmpresa;
        }

        public int getDiaDeProducao() {
            return diaDeProducao;
        }

        public void setClienteProdutorEmpresa(String clienteProdutorEmpresa) {
            this.clienteProdutorEmpresa = clienteProdutorEmpresa;
        }

        public void setDiaDeProducao(int diaDeProducao) {
            this.diaDeProducao = diaDeProducao;
        }

        public void setProdutos(ArrayList<Float> produtos) {
            this.produtos = produtos;
        }

        @Override
        public String toString() {
            return String.format("%s, dia %d", clienteProdutorEmpresa, diaDeProducao);
        }

}

